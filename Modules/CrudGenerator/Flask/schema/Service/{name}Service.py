def get_all_{name}():
    # Retourne une liste vide par défaut
    return []

def create_{name}(data):
    # Crée une nouvelle instance de {name}
    return {"status": "created", "data": data}

def update_{name}(id, data):
    # Met à jour l'instance de {name} avec l'id spécifié
    return {"status": "updated", "id": id, "data": data}

def delete_{name}(id):
    # Supprime l'instance de {name} avec l'id spécifié
    return {"status": "deleted", "id": id}
