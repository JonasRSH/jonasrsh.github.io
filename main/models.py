from django.db import models


# Email field
class ContactMessage(models.Model):
    name = models.CharField(max_length=100)
    email = models.EmailField()
    subject = models.CharField(max_length=200)
    message = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return f"{self.name} - {self.subject}"
    
    class Meta:
        ordering = ['-created_at']  # Neueste zuerst



# Certificates Galerie
class Certificate(models.Model):
    title = models.CharField(max_length=200)  # Name des Zertifikats
    organization = models.CharField(max_length=200)  # Wer hat es ausgestellt
    date_obtained = models.DateField()  # Wann erhalten
    description = models.TextField(blank=True)  # Optionale Beschreibung
    certificate_image = models.ImageField(upload_to='certificates/')  # Das Bild
    
    def __str__(self):
        return f"{self.title} - {self.organization}"
    
    class Meta:
        ordering = ['-date_obtained']  # Neueste zuerst