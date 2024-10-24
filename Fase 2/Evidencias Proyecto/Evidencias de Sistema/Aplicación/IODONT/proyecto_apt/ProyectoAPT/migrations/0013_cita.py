# Generated by Django 4.2.7 on 2024-10-17 15:03

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('ProyectoAPT', '0012_delete_notificacion_horarios_paciente_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='Cita',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('fecha_seleccionada', models.DateField()),
                ('inicio', models.TimeField()),
                ('estudiante', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='citas_estudiante', to=settings.AUTH_USER_MODEL)),
                ('paciente', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='citas_paciente', to=settings.AUTH_USER_MODEL)),
                ('tipo_tratamiento', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='ProyectoAPT.tipotratamiento')),
            ],
        ),
    ]
