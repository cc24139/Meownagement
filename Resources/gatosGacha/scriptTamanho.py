# script para criar uma versão grande, média e pequena das imagens
# imagens na pasta imagens
# novas imagens na pasta imagensTamanhos

from PIL import Image
import os
from pathlib import Path

# tamanhos
widthGrande  = heightGrande  = 400
widthMedia   = heightMedia   = 300
widthPequena = heightPequena = 150

path = "./resources/gatosGacha/imagens"
out  = "./resources/gatosGacha/imagensTamanhos"

def criaPasta(caminho):
    Path(caminho).mkdir(parents=True, exist_ok=True)

def nomeImagem(nomeImg):
    nome = ""
    for letra in nomeImg:
        if letra != 'Q' and letra != ".":
            nome += letra
        else:
            break;
    return nome

def mudaTipo(caminho, nomeImagem):
    extensao = caminho.lower().split(".")[-1]

    if extensao in ["png", "jpeg", "jpg"]:
        img = Image.open(caminho).convert("RGB")  # garante formato RGB

        dir_imagem = os.path.dirname(caminho)
        new_file = os.path.join(dir_imagem, nomeImagem + "Quadrado.jpg")  # padroniza como .jpg

        img.save(new_file, "JPEG")
        print(f"Converted: {caminho} -> {new_file}")

        # se o arquivo original não for .jpg, remove ele
        if not caminho.lower().endswith(".jpg"):
            os.remove(caminho)
            print(f"Deleted: {caminho}")
    else:
        print(f"File format not supported: {caminho}")

def processarImagens():
    # for caminhoImagem in os.listdir(path):
    #     nome = nomeImagem(caminhoImagem)

    #     mudaTipo(path + "/" + caminhoImagem, nome)

    for caminhoImagem in os.listdir(path):
        # abre a imagem
        nome = nomeImagem(caminhoImagem)

        img = Image.open(path + "/" + caminhoImagem)

        pequena = img.resize((widthPequena, heightPequena), resample=Image.LANCZOS)
        media   = img.resize((widthMedia  , heightMedia  ), resample=Image.LANCZOS)
        grande  = img.resize((widthGrande , heightGrande ), resample=Image.LANCZOS)


        criaPasta(out + "/" + nome)

        # versões coloridas
        pequena.save(out + "/" + nome + "/" + nome + "Pequena.jpg")
        media  .save(out + "/" + nome + "/" + nome + "Media.jpg")
        grande .save(out + "/" + nome + "/" + nome + "Grande.jpg")

        # versões em preto e branco
        pequena.convert("L").save(out + "/" + nome + "/" + nome + "PequenaPB.jpg")
        media  .convert("L").save(out + "/" + nome + "/" + nome + "MediaPB.jpg")
        grande .convert("L").save(out + "/" + nome + "/" + nome + "GrandePB.jpg")


if __name__ == "__main__":
    processarImagens()