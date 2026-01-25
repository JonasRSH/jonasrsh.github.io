from django.shortcuts import render, redirect
from django.contrib import messages
from .forms import ContactForm
from django.conf import settings
from .models import ContactMessage
from django.core.mail import send_mail
from decouple import config

def index(request):
    return render(request, 'index.html')


def contact(request):
    if request.method == 'POST':
        form = ContactForm(request.POST)
        if form.is_valid():
            # Daten aus Formular holen
            name = form.cleaned_data['name']
            email = form.cleaned_data['email']
            subject = form.cleaned_data['subject']
            message = form.cleaned_data['message']
            
            # 1. In Datenbank speichern (Backup)
            ContactMessage.objects.create(
                name=name,
                email=email,
                subject=subject,
                message=message
            )
            
            # 2. E-Mail senden
            try:
                send_mail(
                    subject=f"Contact Form: {subject}",
                    message=f"From: {name} <{email}>\n\n{message}",
                    from_email=settings.DEFAULT_FROM_EMAIL,
                    recipient_list=[config('RECIPIENT_EMAIL')],
                    fail_silently=False,
                )
                messages.success(request, f"Success {name}! Message sent.")
            except:
                messages.success(request, f"Thanks {name}! Message saved.")
                
            return redirect('index')
    else:
        form = ContactForm()
    
    return render(request, 'index.html', {'form': form})