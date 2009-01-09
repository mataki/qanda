FCKConfig.Plugins.Add( 'autogrow' ) ;
FCKConfig.Plugins.Add( 'dragresizetable' );
FCKConfig.AutoGrowMax = 1000 ;

FCKConfig.DefaultLanguage               = 'ja' ;

FCKConfig.ToolbarSets["Question"] = [
        ['Source','DocProps','-','Save','NewPage','Preview','-','Templates'],
        ['Cut','Copy','Paste','PasteText','PasteWord','-','Print','SpellCheck'],
        ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
        ['Checkbox','Radio','TextField','Textarea','Select','Button','ImageButton','HiddenField'],
        '/',
        ['Bold','Italic','Underline','StrikeThrough','-','Subscript','Superscript'],
        ['OrderedList','UnorderedList','-','Outdent','Indent','Blockquote','CreateDiv'],
        ['JustifyLeft','JustifyCenter','JustifyRight','JustifyFull'],
        ['Link','Unlink','Anchor'],
        ['Image','Flash','Table','Rule','Smiley','SpecialChar','PageBreak'],
        '/',
        ['Style','FontFormat','FontName','FontSize'],
        ['TextColor','BGColor'],
        ['FitWindow','ShowBlocks','-','About']          // No comma for the last row.
] ;

FCKConfig.FlashBrowser = false ;
FCKConfig.LinkUpload = false ;
FCKConfig.ImageUpload = false ;
FCKConfig.FlashUpload = false ;

