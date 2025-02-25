from flask import Blueprint, request, jsonify
from Service.itemService import get_all_item, create_item, update_item, delete_item

item_bp = Blueprint('item_bp', __name__)

@item_bp.route('/', methods=['GET'])
def get_all():
    data = get_all_item()
    return jsonify(data)

@item_bp.route('/', methods=['POST'])
def create():
    data = request.json
    result = create_item(data)
    return jsonify(result)

@item_bp.route('/<int:id>', methods=['PUT'])
def update(id):
    data = request.json
    result = update_item(id, data)
    return jsonify(result)

@item_bp.route('/<int:id>', methods=['DELETE'])
def delete(id):
    result = delete_item(id)
    return jsonify(result)

