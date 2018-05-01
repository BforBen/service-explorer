#!/usr/bin/env ruby

# This script builds the initial pages required to run the site using the ESD Toolkit files.

require 'csv'
require 'erb'

# Method for creating slug file names
def slugify(title)
	return title.gsub(' ', '-').gsub(/[^\w-]/, '').gsub(/(-){2,}/, '-').downcase
end

# Template for Service docs
serviceTemplate = ERB.new <<-EOF
---
esd_id: <%= row[0] %>
internal: <%= internalService %>
title: "<%= row[1] %>"
history: >-
  <%= row[5] %>

---

<%= row[2] %>

EOF

# Template for docs
genericTemplate = ERB.new <<-EOF
---
esd_id: <%= row[0] %>
title: "<%= row[1] %>"
---

<%= row[2] %>

EOF

# Get the IDs of internal services from the CSV file
internalServices = CSV.read('_data/esdToolkit/internalServices.csv').collect { |row| row[0] }

# For each service in CSV file
CSV.foreach('_data/esdToolkit/services.csv') do |row|
  # Set name for service doc
  name = "_services/" + slugify(row[1]) + ".md"
  
  # Check if it is an internal service
  internalService = internalServices.include?(row[0])
  
  # Write the doc file using the template (only if the file doesn't exist already)
  File.open(name, 'w') { |file| file.write( serviceTemplate.result(binding) ) } unless File.file?(name)
end

# For each function in CSV file
CSV.foreach('_data/esdToolkit/functions.csv') do |row|
  # Set name for service doc
  name = "_functions/" + slugify(row[1]) + ".md"
  
  # Write the doc file using the template (only if the file doesn't exist already)
  File.open(name, 'w') { |file| file.write( genericTemplate.result(binding) ) } unless File.file?(name)
end

# For each power and duty in CSV file
CSV.foreach('_data/esdToolkit/powersAndDuties.csv') do |row|
  # Set name for service doc
  name = "_powers-duties/" + slugify(row[1]) + ".md"

  # Write the doc file using the template (only if the file doesn't exist already)
  File.open(name, 'w') { |file| file.write( genericTemplate.result(binding) ) } unless File.file?(name)
end