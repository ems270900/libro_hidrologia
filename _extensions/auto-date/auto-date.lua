function Meta(meta)
  local months = {
    "enero","febrero","marzo","abril","mayo","junio",
    "julio","agosto","setiembre","octubre","noviembre","diciembre"
  }

  local t = os.date("*t")
  local fecha = string.format("%d de %s de %d",
    t.day, months[t.month], t.year)

  meta.date = fecha
  return meta
end
