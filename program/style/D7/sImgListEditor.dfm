object FormImgListEditor: TFormImgListEditor
  Left = 289
  Top = 196
  Width = 616
  Height = 181
  Color = clBtnFace
  Constraints.MinHeight = 130
  Constraints.MinWidth = 612
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TsSpeedButton
    Left = 9
    Top = 5
    Width = 74
    Height = 36
    Caption = 'Add'
    Flat = True
    OnClick = SpeedButton1Click
    DisabledGlyphKind = []
    ImageIndex = 0
    Images = sAlphaImageList1
  end
  object SpeedButton2: TsSpeedButton
    Left = 86
    Top = 5
    Width = 74
    Height = 36
    Caption = 'Delete'
    Enabled = False
    Flat = True
    OnClick = SpeedButton2Click
    DisabledGlyphKind = []
    ImageIndex = 3
    Images = sAlphaImageList1
  end
  object SpeedButton3: TsSpeedButton
    Left = 240
    Top = 5
    Width = 74
    Height = 36
    Caption = 'Clear'
    Flat = True
    OnClick = SpeedButton3Click
    DisabledGlyphKind = []
    ImageIndex = 4
    Images = sAlphaImageList1
  end
  object SpeedButton4: TsSpeedButton
    Left = 317
    Top = 5
    Width = 74
    Height = 36
    Caption = 'Extract all'
    Enabled = False
    Flat = True
    OnClick = SpeedButton4Click
    DisabledGlyphKind = []
    Images = sAlphaImageList1
  end
  object SpeedButton5: TsSpeedButton
    Left = 163
    Top = 5
    Width = 74
    Height = 36
    Caption = 'Replace'
    Enabled = False
    Flat = True
    OnClick = SpeedButton5Click
    DisabledGlyphKind = []
    ImageIndex = 6
    Images = sAlphaImageList1
  end
  object SpeedButton6: TsSpeedButton
    Left = 394
    Top = 5
    Width = 74
    Height = 36
    Caption = 'Extract as...'
    Enabled = False
    Flat = True
    OnClick = SpeedButton6Click
    DisabledGlyphKind = []
    Images = sAlphaImageList1
  end
  object sBitBtn6: TsBitBtn
    Left = 504
    Top = 76
    Width = 86
    Height = 29
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = sBitBtn6Click
    DisabledGlyphKind = []
    ImageIndex = 2
    Images = sAlphaImageList1
  end
  object sBitBtn7: TsBitBtn
    Left = 504
    Top = 107
    Width = 86
    Height = 29
    Caption = 'Apply'
    TabOrder = 3
    OnClick = sBitBtn7Click
    DisabledGlyphKind = []
    ImageIndex = 5
    Images = sAlphaImageList1
  end
  object sBitBtn5: TsBitBtn
    Left = 504
    Top = 45
    Width = 86
    Height = 29
    Caption = 'Ok'
    Default = True
    TabOrder = 1
    OnClick = sBitBtn5Click
    DisabledGlyphKind = []
    ImageIndex = 1
    Images = sAlphaImageList1
  end
  object ListView1: TsListView
    Left = 8
    Top = 45
    Width = 490
    Height = 58
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'EDIT'
    Color = clWhite
    Columns = <>
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    IconOptions.Arrangement = iaLeft
    IconOptions.AutoArrange = True
    LargeImages = ImageList1
    ParentFont = False
    TabOrder = 0
    OnClick = ListView1Click
    OnDragDrop = ListView1DragDrop
    OnDragOver = ListView1DragOver
    OnKeyDown = ListView1KeyDown
  end
  object sEdit1: TsEdit
    Left = 72
    Top = 112
    Width = 426
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnChange = sEdit1Change
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.Caption = 'Item text:'
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
  end
  object ImageList1: TsAlphaImageList
    DrawingStyle = dsTransparent
    Height = 32
    Width = 32
    Items = <>
    Left = 276
    Top = 56
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 
      'All (*.png, *.ico)|*.png;*.ico|Icons (*.ico)|*.ico|Png (*.png)|*' +
      '.png'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Title = 'Add image'
    Left = 308
    Top = 56
  end
  object sSkinProvider1: TsSkinProvider
    AddedTitle.Font.Charset = DEFAULT_CHARSET
    AddedTitle.Font.Color = clNone
    AddedTitle.Font.Height = -11
    AddedTitle.Font.Name = 'Tahoma'
    AddedTitle.Font.Style = []
    FormHeader.AdditionalHeight = 0
    SkinData.SkinSection = 'FORM'
    GripMode = gmRightBottom
    TitleButtons = <>
    Left = 212
    Top = 56
  end
  object sAlphaImageList1: TsAlphaImageList
    DrawingStyle = dsTransparent
    Items = <
      item
        ImageFormat = ifPNG
        ImgData = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000014B49444154789C6360A010306213B46A15FB2B27AAFC1359ECC59B67
          3F0F543D1424CA54C372812F6FFF3EFE7FE9D7CEFFE77E6CFEFFF2CFDDFF86E5
          025FB0A965C167D0E1EF8B197EFCFBCCE0C0918C530D5E03DEFE7EC4F0E7FF6F
          06053643FC0638B4C9BFFFF8F1232B4C908B97938D818181E1CFFF5F7085CCBC
          FFB90DCBF9BF30303030FC676060E0E263E73C56FD8A99858181814142448A7D
          6DF9114E7CAED9597985818181811BC6CF9A1BF29D81E115AA1726BE0BC5AA19
          5D3C5F6835D41D0C0C4CF86CC507FE43691417404C8680959FAA195EFCB98521
          8E6E040B030303C3A3D777D95DAA74BFC2049979FF73EFACBC8AE2749F7693DF
          DF3F7FFF05B3999B8F83136EC0B1EA57CCC8661B40429B1B59ECDBE7EFBF2E76
          7EE241887C626060C01906FFB10B63015813124C3B76BF13618020BFE0EF8CB9
          41DF1918FE33A0FAF913D12E231A00002DAC71D04A6AAABB0000000049454E44
          AE426082}
      end
      item
        ImageFormat = ifPNG
        ImgData = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000019E49444154789C6360185220323994D1BA53FC5B527DA814C99A59F8
          1818B5AB597F9C7970E8BF7D8FCC1F5E2D06297405AC2A250C9F716866D5AE66
          FD71E2C9AEFF6BBF34FEBFF3FDDC7FBB1EC93F9B8EAD92608229D0CAE7FC52E4
          D3CCA552CCF00D5DB3461EFB9719996BD9AFF0AE61B8F5F32803030303C37F86
          FF1005EB76AC62D5ABE5FC79F3CD85FFD7FEECFFBFE5CA92FFAAC58CDF609A75
          6B397E1E7FB5F5FFB4F7B1FF9BDED8FFBFF3FDDC7F9B1E71B8175858F818D4FF
          31FF6163E6FEC770FBCF190676156E86AEA4D99C650C29DF38B83898A7E42E61
          3BC9329FE1C39FE70C313C93196227B9FEBDB2F0ADDCE76B0CCF181818181819
          18181878B5180C9D72F4CEF4262E603AF86716032FA30803C31371065E412E86
          4B2C6B19BEFE7BC710C7338D21A2DBF1CF95591F657E3C6178891150BC5A0C86
          DED334FFDEF97EEE7FFB5BD7FFFDEF82FFB7BE71FE5FF7DAE2FF9DEFE7FE1B37
          F1FF66E16310C41B55BC5A0C869ED354FFDEF97EEE7FDD6B0B24CD7C8435231B
          E23C59EEEF9DEFE748D78C6488BAFD04C9BF646986814DC756C9AFDBB18A3CCD
          7405008EE0B26A756A2DB40000000049454E44AE426082}
      end
      item
        ImageFormat = ifPNG
        ImgData = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000021B49444154789CA5934B4F13011485BFE9C3B643874EB58921E5996A
          586074589118D476C7CE2E7C04FF819B8A6B7F4461760D897181269AF0D8B011
          E220514C4C4C70E1D22784605A9C81027D41AF8B4E1A6AD50D77796FCEB9E724
          E7C02947F973614212781085B41E0304EC1D70600198CAC0CA3F094CC8F67532
          717DEC1C7AB70AFB47503B0645A1F07D9FB7AB07FCA8319981876D524CC85A31
          44EE44657BD82B8B7EC4043B07F6A207C90F22723520CB41C4846C9BEC391019
          0DC8920F31C132C1706F460EEC7C02A95F56A47E09990571AD3609E637BA918D
          78037C626FE4C0FE35EC15B91194C29022F94164B31F31611EC003A0413A1EF3
          F0710B70FD996004C0BA7B2DA8477BC3385561F69338EF3F43BC274004D24D82
          08A0A85EBE084E06D64D3042608D8F697AA45FA358AAF3E25DC5A9406AF30887
          F0193457A5A7E943F513703F87C01ABFA9EBDA80C6E1C111CF5F169D0AA432B0
          5E01E8F0A2784E101401541F3D2A7A08AC7BB7A27AC7058D52B1C6B339DB29B9
          60138C8B3A3AAA9FBD7A83C007B00B0BF942353D9AECC4DBE1D7D5018D72A1C4
          D3997C13ECEACC8E247576F215761BC16A5A985AFB5046EB0DA3F68529174ACC
          3CFED9F2D904EB4A826474E82C6F56F700A6DA82B41247E4D18054EFC765A90F
          99067B1AECE58422FB991E91C921799D680D527B94234CA46E77A18D9C07CD07
          213F1C0B876BDBBC7AF28DAF85D628FFB74CD12EC00BF616D8F5BF97E9D4F31B
          7904E00FFA0170CB0000000049454E44AE426082}
      end
      item
        ImageFormat = ifPNG
        ImgData = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          61000000B749444154789CED90A10AC2701087BF81C1EE039834189764BE884F
          20C8826388C96851144C223E892F202683C1B4641083DDE07F77675074839561
          F583E3C785EF7770F0E7673C80FD7A75DA2DA6AD3262108F92A01F363D8079A3
          6ED1A4C7ED72C5144CED35A29808EA52CC39EC9DF58ECF72BC61989CBD4AB6B5
          76D822A9A04E11A7EFCCECA26040C7FF38B982C7DDA14E32B2A2A9A0622FB180
          5C41B5DB2BF3866F41108F92E578D62823B6C3C191282E7DF04F014F4B5663C3
          76D6567A0000000049454E44AE426082}
      end
      item
        ImageFormat = ifPNG
        ImgData = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          61000001B049444154789CCD913F485B5114C6BFF74C06F551FC5B1A88845A0C
          41E4265E4D17B1412838D8B445111DE22082D63583B3E02238DC495C3A143A04
          EED28A6241B268A62E4582B4E2607149AB627C28627C37F1389417EA7B3CC1CD
          6FBBF7DCEF77CEF92EF0A814063A04672A0C249C350368149CA9A4A64D7A9943
          8233A57637C909B1CD17DF57C913223853A5BD2DB2A663642D4E5421B6D9CC2C
          91F9B69DAE96D32438533B52763B274808CE94F5718E2E874374353F46823325
          3853E6A7052A0E06A9F83EE29A4E73426639CBCE8CC47C562E8B9AAE5E20D481
          EB2F19A0AE1E9F0BB5E5951FF9D7FBC0D67D41260467EA3C9DA493574FE9A8AF
          958E075FB83ADBD29D1705200F00D4FC0CE5EB0A2A56057A738B67C39AFF0F06
          D0B8C0D971EA5DAFAFB4F615BA61C01F08C03A38409C3FD7FD7892FAFDE768FB
          14387401AAE6A1A84F7D5B876ED423633694F36774D3136ED54B3F7FE16534A8
          FBB4061704C0BF6F2C2E4E5321DE447F07DAAA3BDB999C8E46A9106FA28B0F09
          129CA99C94913B80A4A64D0ACE9439D5EF0ACC8698E331CF3001006F8094D703
          1BE269B6B52365A7572D2765D78694FE7B010FD52D5D0AC7425E5F9824000000
          0049454E44AE426082}
      end
      item
        ImageFormat = ifPNG
        ImgData = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000017349444154789CB592BF4B425114C7BF3ECCE8544ED2E050A08DBA08
          41D01F50A363040E39B4BD0221C90AAC1C92D7D675760A1A1A1241282268A9A5
          A1C1A5C5C56AED9779E586DEDB10577CBD670ED1810B977BEEF773BEE7DC0BFC
          313C7AC31813832E9BA639DC37C91813AA27A4944A4AA93A9D8E628C894AA522
          DC8A186E30A51494529052424A0900884422BE5028E470EA0068915E4AA96ECE
          0DE275036891760200E572F9D3CDAD03A045420804737E7E1EBFA66432E9D3E7
          8661A0582C7661DF2D04309BA99B6DED408B6B5695E64B73BCD17AEFB64444B6
          824622139F195BC6E5C9CA318DA73D5C4A8960CECF8FF279BA699E01004686C8
          D68E0D70DA2E5DD5AC2AB5A6EFB1B390A6892CF1C3BD3512CD3612BBEBFC69FB
          8D7EBE886D061F07180D23DAAC5955BA8BAD221B5BA4803185A55C8A3F6EBD92
          1E6A3F075E00E885DCCA0B2C6EA4F8C3E68B43DC170000FB93CC1B4E473900D4
          33CFAEE25F0100D0B014396E0C081BA05028B87E967F8D2F173307604743CD4B
          0000000049454E44AE426082}
      end
      item
        ImageFormat = ifPNG
        ImgData = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000002B744558744372656174696F6E2054696D6500446F203134204E6F76
          20323030322032333A33313A3434202B3031303084501C480000000774494D45
          07D3080B0E3A131486BA4C000000097048597300000AF000000AF00142AC3498
          0000000467414D410000B18F0BFC61050000026D4944415478DAAD535D485361
          187E768E6767E6E6E6A6CBB3B559BAA021B4CA721568884250465799DA45175D
          4414445437D2851646D04531ACF02EA222EAA282144364C8A05051EAAA304CD1
          996D3AF7CFD9D9CE4F9FC5D611F4AADE8FEFE2F97E9EEFFD9EE77D817F0C8D1A
          D43CB20E5A199337991216A289F4FCE2DCCA08180CA21FDF362328520345A692
          6DCD2D666BB9C9AC678D9E62A6F8C4C3A157DD6FFA03E6B5ED8D082835F83EFF
          F3FAADA74F964449425AC84026239793E9FCE5092D4E0618783626B80BEFA1BA
          ED9337CF77705949203B3908E0114F2543F9237C161F620C5E07585C5C4F7007
          CE830EE7C0E1DDF6F2557E194BB1309E0DBF17453983D574229C3FDC082CEB35
          F04906F8865834153428D3EA7BEA77EDB048B90CFCD39F13FEA9D96B88833973
          B4E94158884EAA5366697CD56941093A749114FDBF095C9CB335C48731F72399
          1C9B091E41373E91AC8C9D7DF7AAC0E71EAB09C865AF650BF94E0EFB0B8B9EE7
          AEF431BF4BA17CB8B1CE954AB8E336F42A1618D670A8027B82354844DC50C62B
          B154D020C247C62329A2BA8C8F6A02D1AEBB547A7A6FD7AC161DE16D38C754E9
          46ED15B441CF02C4A8818206C16CF47649866E040B378123790289ABD857545B
          0B7343BA4F5FCD317494E8B910C4CA742A428B4ACF5F172E6078465ABD5A04EA
          0A5EC25CB0C862B262AB05C6B66686763948A9562312A356A8A472BC3E8A8575
          7520B6CBF7C532F914B1BEA1A001C75961B7119B4C641A117C31BA287C89D771
          218C6D588968C714CEE22DFE941E8D2C4F61E701C04E5E3794C0D6D9623756EB
          7B37ED0575902E93947781BAE848EB65D96A702A86528786D638588A36E37FC6
          2F1946E168B7978D910000000049454E44AE426082}
      end>
    Left = 428
    Top = 56
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Icons|*.ico|Portable Network Graphics|*.png'
    Title = 'Save glyph as ...'
    Left = 340
    Top = 56
  end
end
