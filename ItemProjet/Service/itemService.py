def get_all_item():
    # Retourne une liste vide par dÃ©faut
    return []

def create_item(data):
    # CrÃ©e une nouvelle instance de item
    return {"status": "created", "data": data}

def update_item(id, data):
    # Met Ã  jour l'instance de item avec l'id spÃ©cifiÃ©
    return {"status": "updated", "id": id, "data": data}

def delete_item(id):
    # Supprime l'instance de item avec l'id spÃ©cifiÃ©
    return {"status": "deleted", "id": id}

