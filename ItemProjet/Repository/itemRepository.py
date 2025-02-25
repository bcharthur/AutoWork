# Exemple de repository en mÃ©moire pour item

_item_data = []
_next_id = 1

def get_all():
    return _item_data

def create(data):
    global _next_id
    data['id'] = _next_id
    _next_id += 1
    _item_data.append(data)
    return data

def update(id, data):
    for index, item in enumerate(_item_data):
        if item['id'] == id:
            _item_data[index].update(data)
            return _item_data[index]
    return None

def delete(id):
    global _item_data
    for item in _item_data:
        if item['id'] == id:
            _item_data.remove(item)
            return item
    return None

