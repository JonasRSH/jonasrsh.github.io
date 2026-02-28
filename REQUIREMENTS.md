# Requirements Structure

This project uses multiple requirements files for different environments:

## Files

- **requirements.txt** - Default (points to development)
- **requirements-base.txt** - Core dependencies shared by all environments
- **requirements-dev.txt** - Development tools and testing frameworks
- **requirements-prod.txt** - Production-optimized packages

## Usage

### Development Environment
```bash
pip install -r requirements-dev.txt
# or simply:
pip install -r requirements.txt
```

### Production Environment
```bash
pip install -r requirements-prod.txt
```

### Docker Production
```dockerfile
COPY requirements-prod.txt .
RUN pip install -r requirements-prod.txt
```

## Package Categories

### Base (requirements-base.txt)
- Django framework
- Database connectors
- Core utilities

### Development (requirements-dev.txt)
- Debug toolbar
- Testing frameworks
- Code formatting tools
- Development utilities

### Production (requirements-prod.txt)
- Error monitoring
- Static file serving
- Performance optimization