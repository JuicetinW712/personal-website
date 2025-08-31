locals {
  files_to_upload = merge(
    { for f in fileset(var.source_path, "**/*.html") : f => "text/html" },
    { for f in fileset(var.source_path, "**/*.css") : f => "text/css" },
    { for f in fileset(var.source_path, "**/*.js") : f => "application/javascript" },
    { for f in fileset(var.source_path, "**/*.ico") : f => "image/vnd.microsoft.icon" },
    { for f in fileset(var.source_path, "**/*.png") : f => "image/png" },
    { for f in fileset(var.source_path, "**/*.jpg") : f => "image/jpeg" },
    { for f in fileset(var.source_path, "**/*.jpeg") : f => "image/jpeg" }
  )
}