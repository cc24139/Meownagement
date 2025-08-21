# script para criar uma versão grande, média e pequena das imagens
# imagens na pasta imagens
# novas imagens na pasta imagensTamanhos

from PIL import Image
import os
from pathlib import Path

widthGrande  = heightGrande  = 400
widthMedia   = heightMedia   = 300
widthPequena = heightPequena = 150

path = "./gatosGacha/imagens"
out  = "./gatosGacha/imagensTamanhos"

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
    if caminho.lower().endswith(".png"):
        img = Image.open(caminho).convert("RGB")  # Convert to RGB for JPG
        
        new_file = nomeImagem + ".jpg"
        
        img.save(new_file, "JPEG")
        print(f"Converted: {caminho} -> {new_file}")

        os.remove(caminho)
        print(f"Deleted: {caminho}")
    else:
        print("File is not a .png")

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

        pequena.save(out + "/" + nome + "/" + nome + "Pequena.jpg")
        media  .save(out + "/" + nome + "/" + nome + "Media.jpg")
        grande .save(out + "/" + nome + "/" + nome + "Grande.jpg")


if __name__ == "__main__":
    processarImagens()