desc "Update pot/po files."
task :updatepo do
  require 'gettext/utils'
  GetText.update_pofiles("qanda", #テキストドメイン名(init_gettextで使用した名前)
                         Dir.glob("{app,config,components,lib}/**/*.{rb,erb,rjs}"),  #ターゲットとなるファイル
                         "qanda 0.1.0"  #アプリケーションのバージョン
                         )
end

desc "Create mo-files"
task :makemo do
  require 'gettext/utils'
  GetText.create_mofiles(true, "po", "locale")
end
