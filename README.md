# RogerPont DevBlog - Django Project

Benvingut al repositori del **Projecte Django Blog** per a la unitat de Programació Orientada a Objectes (POO) i introducció a la persistència en BD. Aquest projecte és un blog de desenvolupament web dissenyat amb una interfície elegant de tipus dark mode glassmorphic, que integra una base de dades SQLite totalment estructurada i automatització CI/CD.

## Informació de l'Autor

*   **Nom i Cognoms:** Roger Pont (RogerPont)
*   **Correu Electrònic:** roger.pont.2173@lacetania.cat
*   **Perfil de GitHub:** [https://github.com/RogerPont](https://github.com/RogerPont)

---

## 1. Introducció

Aquest projecte consisteix en la creació d'un sistema de publicació de contingut (blog) fent servir el framework **Django 5.2**. L'objectiu principal és aplicar conceptes clau de POO, persistència en bases de dades mitjançant l'ORM de Django, disseny relacional avançat, modularització en plantilles amb herència, i control d'errors (404 personalitzat).

### Característiques Principals
*   **Pàgina Principal (`/`):** Mostra un resum amb els darrers 3 posts publicats.
*   **Llistat de Posts (`/posts`):** Llistat complet de tots els articles ordenats descendentment per data.
*   **Detall de Post (`/posts/<slug>`):** Pàgina completa de l'article amb la seva imatge, contingut, autor i etiquetes.
*   **Secció d'Autors (`/authors` i `/authors/<id>`):** Llista i perfils complets amb el recompte de posts actius fent servir un mètode del model `Author`.
*   **Secció d'Etiquetes (`/tags` i `/tags/<caption`):** Navegació dels articles mitjançant paraules clau.
*   **Panell de Control Django Admin:** Gestió completa de la creació, modificació i eliminació dels posts, autors i tags.
*   **Base de Dades Poblada (Fixtures):** Més de 15 publicacions de prova reals creades i enllaçades amb 5 autors i 5 etiquetes diferents.
*   **GitHub Actions:** Flux CI/CD que comprova l'estat del servidor, realitza migracions i valida la documentació (`pydoc`).

---

## 2. Instal·lació Ràpida

Sigueu les següents indicacions per configurar i aixecar el projecte localment:

### Pas 1: Clonar el repositori
Clona el repositori públic al teu ordinador:
```bash
git clone https://github.com/RogerPont/my_site.git
cd my_site
```

### Pas 2: Crear i activar l'entorn virtual (Opcional però recomanat)
```bash
python -m venv venv
# A Windows:
venv\Scripts\activate
# A macOS/Linux:
source venv/bin/activate
```

### Pas 3: Instal·lar les dependències
Aquest projecte necessita Django i Pillow per processar les imatges de banner:
```bash
pip install django Pillow
```

### Pas 4: Executar les migracions de la base de dades
Crea i aplica l'estructura de les taules a la base de dades SQLite local:
```bash
cd my_site
python manage.py makemigrations
python manage.py migrate
```

### Pas 5: Carregar les dades de prova (Fixtures)
Carrega els 15+ posts, 5 autors i 5 tags de manera automàtica:
```bash
python manage.py loaddata blog/fixtures/initial_data.json
```

---

## 3. Execució del Projecte

Per arrencar el servidor de desenvolupament local de Django:

```bash
python manage.py runserver
```

Un cop en marxa, pots accedir a les següents adreces des de qualsevol navegador web:

*   **Pàgina del Blog (Frontend):** [http://127.0.0.1:8000/](http://127.0.0.1:8000/)
*   **Panell d'Administració (Admin):** [http://127.0.0.1:8000/admin/](http://127.0.0.1:8000/admin/)
    *   *Usuari Administrador pre-creat:* `admin`
    *   *Contrasenya de l'administrador:* `adminpassword123`

---

## Estructura de Fitxers Clau

*   `blog/models.py`: Estructura dels models `Post`, `Author`, i `Tag` amb validadors i el mètode `get_post_count()`.
*   `blog/views.py`: Desenvolupament de vistes basades en classes (CBV) d'alt rendiment.
*   `blog/static/blog/styles.css`: Disseny modern de la interfície d'usuari.
*   `blog/fixtures/initial_data.json`: Fixtures de dades de qualitat.
*   `.github/workflows/django.yml`: Configuració de GitHub Actions.
