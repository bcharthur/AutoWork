from flask import Blueprint, request, jsonify
from Service.{name}Service import get_all_{name}, create_{name}, update_{name}, delete_{name}

{name}_bp = Blueprint('{name}_bp', __name__)

@{name}_bp.route('/', methods=['GET'])
def get_all():
    data = get_all_{name}()
    return jsonify(data)

@{name}_bp.route('/', methods=['POST'])
def create():
    data = request.json
    result = create_{name}(data)
    return jsonify(result)

@{name}_bp.route('/<int:id>', methods=['PUT'])
def update(id):
    data = request.json
    result = update_{name}(id, data)
    return jsonify(result)

@{name}_bp.route('/<int:id>', methods=['DELETE'])
def delete(id):
    result = delete_{name}(id)
    return jsonify(result)
