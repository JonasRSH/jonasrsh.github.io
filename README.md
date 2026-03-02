# Jonas Website

Persönliche Django-Website von Jonas.

## Voraussetzungen

- [Python 3.11+](https://www.python.org/downloads/)
- [Git](https://git-scm.com/)
- [Docker](https://www.docker.com/) *(für Docker/Production-Setup)*

---

## Installation

### 1. Repository klonen

```bash
git clone https://github.com/JonasRSH/jonasrsh.github.io.git
cd jonasrsh.github.io
```

---

## Option A: Normale Installation (ohne Docker)

### 2. Umgebungsvariablen einrichten

```bash
cp .env.example .env
```

Öffne die `.env`-Datei und trage deine Werte ein (z. B. `SECRET_KEY`, E-Mail-Konfiguration).

### 3. Virtuelle Umgebung erstellen und aktivieren

```bash
python3 -m venv venv
source venv/bin/activate        # Linux / macOS
# oder
venv\Scripts\activate           # Windows
```

### 4. Abhängigkeiten installieren

```bash
pip install -r requirements.txt
```

### 5. Datenbankmigrationen ausführen

```bash
python manage.py migrate
```

### 6. Entwicklungsserver starten

```bash
python manage.py runserver
```

Die Anwendung ist anschließend unter [http://127.0.0.1:8000](http://127.0.0.1:8000) erreichbar.

---

## Option B: Production-Setup mit `production-setup.sh` (Docker)

### 2. Production-Env anlegen

Beim ersten Lauf erstellt das Script eine `.env.prod` aus `.env.example` und stoppt dann bewusst.

```bash
chmod +x production-setup.sh
./production-setup.sh
```

Danach `.env.prod` mit echten Werten ausfüllen (insbesondere `SECRET_KEY`, DB, Mail etc.) und erneut starten:

```bash
./production-setup.sh
```

Das Script führt automatisch aus:

- `docker-compose up -d`
- `docker-compose exec web python manage.py migrate`
- `docker-compose exec web python manage.py collectstatic --noinput`

Container-Status prüfen:

```bash
docker-compose ps
```

---

## Docker/Make-Setup (alternativ)

### Entwicklungsumgebung starten

```bash
make dev
```

### Produktionsumgebung starten

```bash
make prod
```

### Alle verfügbaren Make-Befehle anzeigen

```bash
make help
```

---

## Nützliche Befehle

| Befehl | Beschreibung |
|--------|-------------|
| `make install` | Entwicklungsabhängigkeiten installieren |
| `make runserver` | Django-Entwicklungsserver starten |
| `make migrate` | Datenbankmigrationen ausführen |
| `make test` | Tests ausführen |
| `make lint` | Code-Qualität prüfen |
| `make format` | Code formatieren |
