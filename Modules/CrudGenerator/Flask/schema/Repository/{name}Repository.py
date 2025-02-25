# Exemple de repository en mémoire pour {name}

_{name}_data = []
_next_id = 1

def get_all():
    return _{name}_data

def create(data):
    global _next_id
    data['id'] = _next_id
    _next_id += 1
    _{name}_data.append(data)
    return data

def update(id, data):
    for index, item in enumerate(_{name}_data):
        if item['id'] == id:
            _{name}_data[index].update(data)
            return _{name}_data[index]
    return None

def delete(id):
    global _{name}_data
    for item in _{name}_data:
        if item['id'] == id:
            _{name}_data.remove(item)
            return item
    return None
