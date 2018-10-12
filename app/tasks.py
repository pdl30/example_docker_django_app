from celery import shared_task
from celery import task
from django.core.mail import EmailMessage
# from protocols.reports_6_0_0 import InterpretedGenome, InterpretationRequestRD, CancerInterpretationRequest, ClinicalReport

@shared_task
def hello():
    print("Hello there!")


@task
def send_email():
    subject, from_email, to = 'Docker', 'bioinformatics@gosh.nhs.uk', 'patrick.lombard@gosh.nhs.uk'
    text_content = f'Hi from docker'
    msg = EmailMessage(subject, text_content, from_email, [to])
    msg.send()
