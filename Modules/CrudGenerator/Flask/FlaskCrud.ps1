function Generate-FlaskCrud {
    param(
        [Parameter(Mandatory=$true)] [string]$ProjectPath,
        [Parameter(Mandatory=$true)] $DbInfo
    )

    Write-HostColored -Color "Yellow" "`n=== Génération du CRUD Flask ==="

    $tableName = $DbInfo.Table
    if (-not $tableName) {
        Write-HostColored -Color "Red" "Aucune table sélectionnée. CRUD annulé."
        return
    }

    # Fichiers Python
    $controllerPath = Join-Path $ProjectPath ("Controller\" + $tableName + "Controller.py")
    $servicePath    = Join-Path $ProjectPath ("Service\" + $tableName + "Service.py")
    $entityPath     = Join-Path $ProjectPath ("Entity\" + $tableName + ".py")
    $repoPath       = Join-Path $ProjectPath ("Repository\" + $tableName + "Repository.py")
    $datatablePath  = Join-Path $ProjectPath ("Datatable\" + $tableName + "Datatable.py")

@"
# Flask Controller for $tableName
from flask import Blueprint, request, jsonify

$tableName`_bp = Blueprint('$tableName', __name__)

@$tableName`_bp.route('/', methods=['GET'])
def get_all_$tableName():
    return jsonify([])

@$tableName`_bp.route('/', methods=['POST'])
def create_$tableName():
    data = request.json
    return jsonify({'status': 'created', 'data': data})

@$tableName`_bp.route('/<id>', methods=['PUT'])
def update_$tableName(id):
    data = request.json
    return jsonify({'status': 'updated', 'id': id, 'data': data})

@$tableName`_bp.route('/<id>', methods=['DELETE'])
def delete_$tableName(id):
    return jsonify({'status': 'deleted', 'id': id})
"@ | Out-File $controllerPath -Encoding utf8

@"
# Flask Service for $tableName
def get_all_$tableName():
    pass

def create_$tableName(data):
    pass

def update_$tableName(id, data):
    pass

def delete_$tableName(id):
    pass
"@ | Out-File $servicePath -Encoding utf8

@"
# Flask Entity (Model) for $tableName
class $($tableName.capitalize()):
    def __init__(self):
        pass
"@ | Out-File $entityPath -Encoding utf8

@"
# Flask Repository for $tableName
def get_all():
    pass

def create(data):
    pass

def update(id, data):
    pass

def delete(id):
    pass
"@ | Out-File $repoPath -Encoding utf8

@"
# Flask Datatable for $tableName
def build_datatable():
    pass
"@ | Out-File $datatablePath -Encoding utf8

    # JS
    $jsDir = Join-Path $ProjectPath ("static\js\" + $tableName)
@"
console.log('create.js for $tableName');
"@ | Out-File (Join-Path $jsDir "create.js") -Encoding utf8

@"
console.log('edit.js for $tableName');
"@ | Out-File (Join-Path $jsDir "edit.js") -Encoding utf8

@"
console.log('delete.js for $tableName');
"@ | Out-File (Join-Path $jsDir "delete.js") -Encoding utf8

@"
console.log('datatable.js for $tableName');
"@ | Out-File (Join-Path $jsDir "datatable.js") -Encoding utf8

    # Templates
    $templateDir = Join-Path $ProjectPath ("templates\" + $tableName)
@"
<!-- Index.html for $tableName -->
<h1>Index of $tableName</h1>
"@ | Out-File (Join-Path $templateDir "Index.html") -Encoding utf8

    $fragmentsDir = Join-Path $templateDir "Fragments\Modals"
@"
<!-- Create.html -->
<div>
    <h2>Create $tableName</h2>
    <!-- Form here -->
</div>
"@ | Out-File (Join-Path $fragmentsDir "Create.html") -Encoding utf8

@"
<!-- Edit.html -->
<div>
    <h2>Edit $tableName</h2>
    <!-- Form here -->
</div>
"@ | Out-File (Join-Path $fragmentsDir "Edit.html") -Encoding utf8

@"
<!-- Delete.html -->
<div>
    <h2>Delete $tableName</h2>
    <!-- Confirmation here -->
</div>
"@ | Out-File (Join-Path $fragmentsDir "Delete.html") -Encoding utf8

@"
<!-- datatable.html -->
<table>
    <thead>
        <tr><th>ID</th><th>Columns...</th></tr>
    </thead>
    <tbody>
    </tbody>
</table>
"@ | Out-File (Join-Path (Join-Path $templateDir "Fragments") "datatable.html") -Encoding utf8

@"
<!-- filtres.html -->
<div>
    <label>Rechercher</label>
    <input type='text' />
</div>
"@ | Out-File (Join-Path (Join-Path $templateDir "Fragments") "filtres.html") -Encoding utf8

    Write-HostColored -Color "Green" "CRUD Flask pour la table '$tableName' généré avec succès."
}
