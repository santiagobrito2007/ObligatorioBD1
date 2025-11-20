SELECT s.nombre_sala,
       COUNT(r.id_reserva) AS cantidad_reservas
FROM sala s
LEFT JOIN reserva r ON r.id_sala = s.id_sala
GROUP BY s.nombre_sala
ORDER BY cantidad_reservas DESC;

SELECT t.id_turno, t.hora_inicio, t.hora_fin,
       COUNT(r.id_reserva) AS cantidad_reservas
FROM turno t
LEFT JOIN reserva r ON r.id_turno = t.id_turno
GROUP BY t.id_turno, t.hora_inicio, t.hora_fin
ORDER BY cantidad_reservas DESC;

SELECT s.nombre_sala,
       AVG(p.total_participantes) AS promedio_participantes
FROM sala s
JOIN reserva r ON r.id_sala = s.id_sala
JOIN (
    SELECT id_reserva, COUNT(*) AS total_participantes
    FROM reserva_participante
    GROUP BY id_reserva
) AS p ON p.id_reserva = r.id_reserva
GROUP BY s.nombre_sala;

SELECT pa.nombre_programa,
       f.nombre AS facultad,
       COUNT(rp.id_reserva) AS cantidad_reservas
FROM reserva_participante rp
JOIN participante_programa_academico pa ON rp.ci = pa.ci
JOIN programa_academico prog ON pa.nombre_programa = prog.nombre_programa
JOIN facultad f ON prog.id_facultad = f.id_facultad
GROUP BY pa.nombre_programa, f.nombre;

SELECT e.nombre_edificio,
       COUNT(r.id_reserva) AS reservas_realizadas
FROM edificio e
LEFT JOIN sala s ON s.nombre_edificio = e.nombre_edificio
LEFT JOIN reserva r ON r.id_sala = s.id_sala
GROUP BY e.nombre_edificio;

SELECT p.ci,
       p.nombre,
       p.apellido,
       prog.tipo AS tipo_academico,
       COUNT(rp.id_reserva) AS total_reservas,
       SUM(r.estado = 'finalizada') AS asistencias
FROM participante p
LEFT JOIN reserva_participante rp ON rp.ci = p.ci
LEFT JOIN reserva r ON r.id_reserva = rp.id_reserva
LEFT JOIN participante_programa_academico pa ON pa.ci = p.ci
LEFT JOIN programa_academico prog ON prog.nombre_programa = pa.nombre_programa
GROUP BY p.ci, p.nombre, p.apellido, prog.tipo;

SELECT prog.tipo AS tipo_academico,
       COUNT(*) AS cantidad_sanciones
FROM sancion_participante sp
JOIN participante_programa_academico pa ON sp.ci = pa.ci
JOIN programa_academico prog ON pa.nombre_programa = prog.nombre_programa
GROUP BY prog.tipo;


SELECT 
    ROUND(SUM(estado = 'finalizada') / COUNT(*) * 100, 2) AS porcentaje_utilizadas,
    ROUND(SUM(estado IN ('cancelada')) / COUNT(*) * 100, 2) AS porcentaje_no_utilizadas
FROM reserva;










