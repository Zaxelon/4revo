unit sDBLookupComboBox;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, DBCtrls, math,
  {$IFNDEF DELPHI5}Types, {$ENDIF}
  {$IFDEF LOGGED}sDebugMsgs, {$ENDIF}
  {$IFDEF DELPHI_XE2} UItypes, {$ENDIF}
  sConst, acntUtils, sGraphUtils, sCommonData, sDefaults, sGlyphUtils, acSBUtils;


type
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsDBLookupComboBox = class(TDBLookupComboBox)
  private
    FButtonMargin: integer;
    FBoundLabel: TsBoundLabel;
    FCommonData: TsCommonData;
    FDisabledKind: TsDisabledKind;
    function ButtonRect: TRect;
    procedure SetButtonMargin(const Value: integer);
    procedure SetDisabledKind(const Value: TsDisabledKind);
  protected
    lboxhandle: hwnd;
    ListSW: TacScrollWnd;
    procedure PaintBorder;
    procedure PrepareCache;
    procedure PaintText;
    procedure OurPaintHandler;
    procedure WndProc(var Message: TMessage); override;
//    procedure WMMouseWheel(var Message: TMessage); message WM_MOUSEWHEEL;
  public
    procedure AfterConstruction; override;
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure DropDown; override;
    function CanFocus: Boolean; override;
    procedure Loaded; override;

    property Color;
    procedure Invalidate; override;
    procedure PaintButton;
    function ButtonHeight: integer;

    function Focused: Boolean; override;
    property ButtonMargin: integer read FButtonMargin write SetButtonMargin default 2;
  published
    property BoundLabel: TsBoundLabel read FBoundLabel write FBoundLabel;
    property DisabledKind: TsDisabledKind read FDisabledKind write SetDisabledKind default DefDisabledKind;
    property SkinData: TsCommonData read FCommonData write FCommonData;
  end;


implementation

uses sMessages, sMaskData, sStyleSimply, sSkinProps, sVCLUtils, sAlphaGraph;


type
{$HINTS OFF}
  TsDBLookupComboBox_ = class(TDBLookupControl)
  private
    FDataList: TPopupDataList;
    FButtonWidth: Integer;
    FText: string;
    FDropDownRows,
    FDropDownWidth: Integer;
    FDropDownAlign: TDropDownAlign;
    FListVisible,
    FPressed,
    FTracking: Boolean;
    FAlignment: TAlignment;
  end;
{$HINTS ON}


procedure TsDBLookupComboBox.AfterConstruction;
begin
  inherited AfterConstruction;
  FCommonData.Loaded;
end;


function TsDBLookupComboBox.ButtonHeight: integer;
begin
  with FCommonData.SkinManager.ConstData.ComboBtn do
    if FCommonData.Skinned and (GlyphIndex > -1) then
      Result := HeightOfImage(FCommonData.SkinManager.ma[GlyphIndex])
    else
      Result := 16;
end;


function TsDBLookupComboBox.ButtonRect: TRect;
var
  w: integer;
begin
  w := GetSystemMetrics(SM_CXVSCROLL);
  Result.Left := iff(UseRightToLeftAlignment, 2, Width - w - 2);
  Result.Top := 2;
  Result.Right := Result.Left + w;
  Result.Bottom := Height - 2;
end;


function TsDBLookupComboBox.CanFocus: Boolean;
begin
  Result := False;
  if Visible then
    Result := inherited CanFocus;
end;


constructor TsDBLookupComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csFixedHeight, csFramed, csOpaque];
  TControlCanvas(Canvas).Control := self;
  ParentColor := False;
  FCommonData := TsCommonData.Create(Self, True);
  FCommonData.COC := COC_TsComboBox;
  FDisabledKind := DefDisabledKind;
  FBoundLabel := TsBoundLabel.Create(Self, FCommonData);
  FButtonMargin := 2;
  lBoxHandle := 0;
  DoubleBuffered := True;
end;


destructor TsDBLookupComboBox.Destroy;
begin
  if lBoxHandle <> 0 then begin
    SetWindowLong(lBoxHandle, GWL_STYLE, GetWindowLong(lBoxHandle, GWL_STYLE) and not WS_THICKFRAME or WS_BORDER);
    UninitializeACScroll(lBoxHandle, True, False, ListSW);
    lBoxHandle := 0;
  end;
  if Assigned(ListSW) then
    FreeAndNil(ListSW);

  FreeAndNil(FBoundLabel);
  if Assigned(FCommonData) then
    FreeAndNil(FCommonData);

  inherited Destroy;
end;


procedure TsDBLookupComboBox.DropDown;
var
  sp: TacSkinParams;
begin
  if SkinData.Skinned and (TsDBLookupComboBox_(Self).FDataList <> nil) and (ListSW = nil) then begin
    lBoxHandle := TsDBLookupComboBox_(Self).FDataList.Handle;
    sp.Control := nil;
    sp.HorzScrollBtnSize := -1;
    sp.HorzScrollSize := -1;
    sp.VertScrollBtnSize := -1;
    sp.VertScrollSize := -1;
    sp.UseSkinFontColor := True;
    sp.UseSkinColor := True;
    sp.SkinSection := s_Edit;
    ListSW := TacComboListWnd.Create(TsDBLookupComboBox_(Self).FDataList.Handle, nil, SkinData.SkinManager, sp, False);
    TacComboListWnd(ListSW).DBScroll := True;
    TacComboListWnd(ListSW).SimplyBox := False;
    ListSW.Tag := ACT_RELCAPT;
  end;
  inherited;
end;


function TsDBLookupComboBox.Focused: Boolean;
var
  FocusedWnd: HWND;
begin
  Result := False;
  if HandleAllocated then begin
    FocusedWnd := GetFocus;
    Result := (FocusedWnd <> 0) and ((FocusedWnd = Handle) or (FocusedWnd = lBoxHandle));
  end;
end;


procedure TsDBLookupComboBox.Invalidate;
begin
  if Focused then
    FCommonData.FFocused := True;

  inherited Invalidate;
end;


procedure TsDBLookupComboBox.Loaded;
begin
  inherited Loaded;
  FCommonData.Loaded;
  if FCommonData.Skinned then begin
    if not FCommonData.CustomColor then
      Color := FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[0].Color;

    if not FCommonData.CustomFont then
      Font.Color := FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[0].FontColor.Color;
  end;
end;


procedure TsDBLookupComboBox.OurPaintHandler;
const
  BordWidth = 3;
var
  DC, SavedDC: hdc;
  PS: TPaintStruct;
begin
  BeginPaint(Handle, PS);
  DC := GetWindowDC(Handle);
  SavedDC := SaveDC(DC);
  try
    if not FCommonData.Updating then begin
      FCommonData.BGChanged := FCommonData.BGChanged or FCommonData.HalfVisible or GetBoolMsg(Parent, AC_GETHALFVISIBLE);
      FCommonData.HalfVisible := not RectInRect(Parent.ClientRect, BoundsRect);
      if FCommonData.BGChanged then begin
        InitCacheBmp(FCommonData);
        PrepareCache;
      end;
      UpdateCorners(FCommonData, 0);
      BitBlt(DC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY)
{$IFDEF DYNAMICCACHE}
      if Assigned(FCommonData.FCacheBmp) then
        FreeAndNil(FCommonData.FCacheBmp);
{$ENDIF}
    end
    else
      FCommonData.Updating := True;
  finally
    RestoreDC(DC, SavedDC);
    ReleaseDC(Handle, DC);
    EndPaint(Handle, PS);
  end;
end;


procedure TsDBLookupComboBox.PaintBorder;
const
  BordWidth = 3;
var
  DC, SavedDC: HDC;
begin
  DC := GetWindowDC(Handle);
  SavedDC := SaveDC(DC);
  try
    if FCommonData.BGChanged then begin
      InitCacheBmp(FCommonData);
      PrepareCache;
    end;
    UpdateCorners(FCommonData, 0);
    BitBltBorder(DC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, BordWidth);
{$IFDEF DYNAMICCACHE}
    if Assigned(FCommonData.FCacheBmp) then
      FreeAndNil(FCommonData.FCacheBmp);
{$ENDIF}
  finally
    RestoreDC(DC, SavedDC);
    ReleaseDC(Handle, DC);
  end;
end;


procedure TsDBLookupComboBox.PaintButton;
var
  R: TRect;
  C: TColor;
  Mode: integer;
  TmpBtn: TBitmap;
begin
  if ListVisible then
    Mode := 2
  else
    Mode := integer(ControlIsActive(FCommonData));

  R := ButtonRect;
  with SkinData.SkinManager.ConstData.ComboBtn do begin
    if SkinIndex > -1 then begin
      TmpBtn := CreateBmpLike(FCommonData.FCacheBmp);
      BitBlt(TmpBtn.Canvas.Handle, 0, 0, TmpBtn.Width, TmpBtn.Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
      PaintItem(SkinIndex, MakeCacheInfo(FCommonData.FCacheBmp),
                True, Mode, R, Point(0, 0), FCommonData.FCacheBmp, FCommonData.SkinManager, BGIndex[0], BGIndex[1]);
      FreeAndNil(TmpBtn);
    end;
    if FCommonData.SkinManager.IsValidImgIndex(GlyphIndex) then
      DrawSkinGlyph(FCommonData.FCacheBmp, Point(R.Left + (WidthOf(R) - WidthOfImage(FCommonData.SkinManager.ma[GlyphIndex])) div 2,
                    (Height - ButtonHeight) div 2), Mode, 1, FCommonData.SkinManager.ma[GlyphIndex], MakeCacheInfo(SkinData.FCacheBmp))
    else begin // Paint without glyph
      if SkinIndex >= 0 then
        C := FCommonData.SkinManager.gd[SkinIndex].Props[min(Mode, 1)].FontColor.Color
      else
        C := ColorToRGB(clWindowText);

      DrawColorArrow(FCommonData.FCacheBmp.Canvas, C, R, asBottom);
    end;
  end;
end;


procedure TsDBLookupComboBox.PaintText;
var
  R: TRect;
begin
  R := Rect(4, 3, ButtonRect.Left, Height - 3);
  FCommonData.FCacheBMP.Canvas.Font.Assign(Font);
  if Focused then begin
    FCommonData.FCacheBMP.Canvas.Brush.Color := clHighLight;
    FCommonData.FCacheBMP.Canvas.Font.Color := ColorToRGB(clHighLightText);
  end
  else begin
    FCommonData.FCacheBMP.Canvas.Brush.Color := FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[0].Color;
    FCommonData.FCacheBMP.Canvas.Font.Color  := FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[0].FontColor.Color;
  end;
  FillDC(FCommonData.FCacheBMP.Canvas.Handle, R, FCommonData.FCacheBMP.Canvas.Brush.Color);
  acDrawText(FCommonData.FCacheBMP.Canvas.Handle, Text, R,
                DT_NOPREFIX or DT_TOP or DT_SINGLELINE or DT_WORDBREAK or GetStringFlags(Self, {ListField..}TsDBLookupComboBox_(Self).FAlignment));

  if Focused then
    FCommonData.FCacheBMP.Canvas.DrawFocusRect(R);
end;


procedure TsDBLookupComboBox.PrepareCache;
begin
  InitCacheBmp(FCommonData);
  PaintItem(FCommonData, GetParentCache(FCommonData), True, integer(ControlIsActive(FCommonData)),
                         MkRect(Width, Height), Point(Left, top), FCommonData.FCacheBmp, False);
  PaintText;
  PaintButton;
  if not Enabled then
    BmpDisabledKind(FCommonData.FCacheBmp, FDisabledKind, Parent, GetParentCache(FCommonData), Point(Left, Top));
end;


procedure TsDBLookupComboBox.SetButtonMargin(const Value: integer);
begin
  if FButtonMargin <> Value then begin
    FButtonMargin := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsDBLookupComboBox.SetDisabledKind(const Value: TsDisabledKind);
begin
  if FDisabledKind <> Value then begin
    FDisabledKind := Value;
    FCommonData.Invalidate;
  end;
end;

{
procedure TsDBLookupComboBox.WMMouseWheel(var Message: TMessage);
begin
  case Message.Msg of
    WM_MOUSEWHEEL: begin
      Message.Msg := WM_KEYDOWN;
      Message.lParam := 0;
      Message.wParam := iff(SmallInt(Message.wParamHi) > 0, VK_UP, VK_DOWN);
      MainWndProc(Message);
    end;
  end;
end;
}

procedure TsDBLookupComboBox.WndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_CTRLHANDLED: begin
        Message.Result := 1;
        Exit;
      end;

      AC_REMOVESKIN: begin
        CommonWndProc(Message, FCommonData);
        Color := clWindow;
        if lBoxHandle <> 0 then begin
          SetWindowLong(lBoxHandle, GWL_STYLE, GetWindowLong(lBoxHandle, GWL_STYLE) and not WS_THICKFRAME or WS_BORDER);
          UninitializeACScroll(lBoxHandle, True, False, ListSW);
          lBoxHandle := 0;
        end;
        Exit;
      end;

      AC_REFRESH: begin
        CommonWndProc(Message, FCommonData);
        if FCommonData.Skinned then begin
          if not FCommonData.CustomColor then
            Color := FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[0].Color;

          if not FCommonData.CustomFont then
            Font.Color := FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[0].FontColor.Color;
        end;
        Repaint;
        Exit;
      end;

      AC_SETNEWSKIN: begin
        CommonWndProc(Message, FCommonData);
        Exit;
      end;

      AC_DROPPEDDOWN:
        Message.WParamLo := integer(ListVisible);

      AC_ENDPARENTUPDATE:
        if FCommonData.Updating then begin
          FCommonData.FUpdating := False;
          Repaint;
          Exit;
        end;

      AC_GETDEFINDEX: begin
        if FCommonData.SkinManager <> nil then
          Message.Result := FCommonData.SkinManager.GetSkinIndex(s_ComboBox) + 1;

        Exit;
      end;
    end;

  if not ControlIsReady(Self) or not FCommonData.Skinned then
    inherited
  else begin
    case Message.Msg of
      WM_CTLCOLOREDIT, WM_ERASEBKGND:
        Exit;

      WM_SETFOCUS, CM_ENTER:
        if CanFocus then begin
          FCommonData.FFocused := True;
          FCommonData.BGChanged := True;
          if (Message.Msg = WM_SETFOCUS) or not ListVisible then
            inherited;

          Exit;
        end;

      WM_MOUSEWHEEL:
        if Integer(Message.WParam) < 0 then
          Perform(WM_KEYDOWN, VK_DOWN, 0)
        else
          Perform(WM_KEYDOWN, VK_UP, 0);

      WM_KILLFOCUS, CM_EXIT: begin
        FCommonData.FFocused := False;
        FCommonData.BGChanged := True;
        if IsWindowVisible(Handle) then
          inherited
        else begin
          if TsDBLookupComboBox_(Self).FDataList.Handle <> 0 then
            ShowWindow(TsDBLookupComboBox_(Self).FDataList.Handle, SW_HIDE);

          TsDBLookupComboBox_(Self).FListVisible := False;
        end;
        Exit
      end;

      WM_NCPAINT: begin
        PaintBorder;
        Exit;
      end;

      CM_CANCELMODE: begin
        StopTimer(SkinData);
        SkinData.BGChanged := True;
      end;

      WM_PRINT: begin
        ControlState := ControlState + [csPaintCopy];
        if not FCommonData.CustomColor then
          Color := FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[0].Color;

        if not FCommonData.CustomFont then
          Font.Color := FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[0].FontColor.Color;

        if FCommonData.BGChanged then
          PrepareCache;

        BitBlt(hdc(Message.WParam), 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
        ControlState := ControlState - [csPaintCopy];
        Exit;
      end;

      WM_PAINT: begin
        if Focused then
          inherited;

        OurPaintHandler;
        Exit;
      end;
    end;
    CommonWndProc(Message, FCommonData);
    inherited;
    case Message.Msg of
      CM_VISIBLECHANGED, CM_ENABLEDCHANGED, WM_SETFONT:
        FCommonData.Invalidate;
    end;
  end;
  if Assigned(BoundLabel) then
    BoundLabel.HandleOwnerMsg(Message, Self);
end;

end.
