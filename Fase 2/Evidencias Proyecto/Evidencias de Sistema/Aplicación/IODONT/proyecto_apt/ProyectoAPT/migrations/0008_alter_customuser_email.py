# Generated by Django 4.2.7 on 2024-10-10 20:30

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ProyectoAPT', '0007_rename_horainicial_horarios_inicio'),
    ]

    operations = [
        migrations.AlterField(
            model_name='customuser',
            name='email',
            field=models.EmailField(max_length=254, unique=True),
        ),
    ]
