namespace :doc do
  namespace :diagram do
    desc "Generate Model diagrams."
    task :models do
      # SVG
      sh "railroad -i -l -a -m -M | dot -Tsvg | sed 's/font-size:14.00/font-size:11.00/g' > doc/models.svg"
      # PNG
      sh "railroad -i -l -a -m -M | dot -Tpng > doc/models.png"
    end

    desc "Generate Controller diagrams."
    task :controllers do
      # SVG
      sh "railroad -i -l -C | neato -Tsvg | sed 's/font-size:14.00/font-size:11.00/g' > doc/controllers.svg"
      # PNG
      sh "railroad -i -l -C | neato -Tpng > doc/controllers.png"
    end
  end
  desc "Generate Model and Controller diagrams."
  task :diagrams => %w(diagram:models diagram:controllers)
end