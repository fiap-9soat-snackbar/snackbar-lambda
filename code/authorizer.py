import json
import jwt  # PyJWT

# Configurações do JWT
JWT_SECRET = "3cfa76ef14937c1c0ea519f8fc057a80fcd04a7420f8e8bcd0a7567c272e007b"
JWT_ALGORITHM = "HS256"

def lambda_handler(event, context):
    """
    Lambda Authorizer para HTTP API (payload format = 2.0).
    Retorna:
      {
        "isAuthorized": True/False
      }
    """
    try:
        # Log do evento com serialização segura
        print("Event recebido:", json.dumps(event, default=str))

        headers = event.get("headers", {})
        auth_header = headers.get("authorization", "")

        # Verifica se o header começa com "Bearer "
        if not auth_header.startswith("Bearer "):
            return {"isAuthorized": False}

        # Extrai o token
        token = auth_header.split(" ", 1)[1]

        try:
            # Tenta decodificar o token (incluindo verificação de expiração)
            jwt.decode(token, JWT_SECRET, algorithms=[JWT_ALGORITHM])
            # Token válido: autoriza o acesso
            return {"isAuthorized": True}
        except jwt.InvalidTokenError:
            print("Token inválido ou expirado.")
            return {"isAuthorized": False}

    except Exception as e:
        print("Erro inesperado:", e)
        return {"isAuthorized": False}
