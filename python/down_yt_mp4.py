from pytube import YouTube

def download_video(url, output_path='.'):
    try:
        yt = YouTube(url)
    except Exception as e:
        print(f"Erreur lors de la récupération de la vidéo : {e}")
        return

    # Sélectionne le flux MP4 progressif (audio + vidéo) avec la résolution la plus élevée
    stream = yt.streams.filter(file_extension='mp4').first()
    
    if stream is None:
        print("Aucun flux MP4 progressif disponible pour cette vidéo.")
        return

    print(f"Téléchargement de : {yt.title}")
    try:
        stream.download(output_path=output_path)
        print("Téléchargement terminé.")
    except Exception as e:
        print(f"Erreur lors du téléchargement : {e}")

if __name__ == "__main__":
    url = input("Entrez l'URL de la vidéo YouTube : ")
    download_video(url)
