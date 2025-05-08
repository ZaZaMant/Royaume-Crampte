## Contents
* Godot project dans (`demo/`)
* godot-cpp en tant que submodule (`godot-cpp/`)
* GitHub Issues template (`.github/ISSUE_TEMPLATE.yml`)
* GitHub CI/CD workflows to publish your library packages when creating a release (`.github/workflows/builds.yml`)
* Les fichiers en c++ (utilisé par GDExtension) (`src/`)
* setup to automatically generate `.xml` files in a `doc_classes/` directory to be parsed by Godot as [GDExtension built-in documentation](https://docs.godotengine.org/en/stable/tutorials/scripting/gdextension/gdextension_docs_system.html)


## Snippets

''' gd-cpp-class-header '''

A utiliser dans le projet pour créer le skelette d'un .h d'une classe



''' gd-cpp-class '''

a utiliser dans le projet pour créer le skelette d'un .cpp d'une classe




''' gd-cpp-property-bindings '''





''' gd-cpp-method-bindings '''





## Usage - Actions

This repository comes with a GitHub action that builds the GDExtension for cross-platform use. It triggers automatically for each pushed change. You can find and edit it in [builds.yml](.github/workflows/builds.yml).
After a workflow run is complete, you can find the file `godot-cpp-template.zip` on the `Actions` tab on GitHub.
