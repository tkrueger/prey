require 'java_imports'
require 'entity'

java_import 'com.jme3.app.SimpleApplication'
java_import 'com.jme3.scene.shape.Box'
java_import 'com.jme3.scene.Geometry'
java_import 'com.jme3.material.Material'
java_import 'com.jme3.math.ColorRGBA'

class Game < SimpleApplication

    class SomeEntity < Entity

    end

    def initialize
      super
    end

    def simpleInitApp
      b = Box.new(1, 1, 1)
      geom = Geometry.new("Box", b)
      mat = Material.new(assetManager, "Common/MatDefs/Misc/Unshaded.j3md")
      mat.setColor("Color", ColorRGBA::Blue)
      geom.setMaterial(mat)
      rootNode.attachChild(geom)
    end
end
