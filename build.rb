#!/usr/bin/env ruby

# This script builds the initial pages required to run the site using the ESD Toolkit files.

require 'csv'
require 'erb'

# Method for creating slug file names
def slugify(title)
  title.strip!
	return title.gsub(' ', '-').gsub(/[^\w-]/, '').gsub(/(-){2,}/, '-').downcase
end

# Template for Service docs
serviceTemplate = ERB.new <<-EOF
---
esd_id: <%= row[0] %>
title: "<%= row[1] %>"
history: >-
  <%= row[5] %>
function: <%= function %>
interactions: [<%= interactions %>]
powers: [<%= powers %>]
internal: <%= internalService %>

---

<%= row[2] %>

EOF

# Template for docs
genericTemplate = ERB.new <<-EOF
---
title: "<%= row[1] %>"
esd_id: <%= row[0] %>
type: <%= row[6] %>
parent_id: <%= row[7] %> 
---

<%= row[2] %>

EOF

# Get the IDs of internal services from the CSV file
internalServices = CSV.read('_data/esdToolkit/internalServices.csv').collect { |row| row[0] }

# Get the IDs of services for the organisation type - currently set to '42' (London Borough)
organisationServices = CSV.read('_data/esdToolkit/organisationTypes_services.csv')
    .select { |row| row[0] == '42' }
    .collect { |row| row[12] }

# Get the IDs of functions for the organisation type - currently set to '42' (London Borough)
organisationFunctions = CSV.read('_data/esdToolkit/organisationTypes_functions.csv')
    .select { |row| row[0] == '42' }
    .collect { |row| row[12] }

# Load service to functions
serviceFunctions = CSV.read('_data/esdToolkit/services_functions.csv')

# Load the service interactions
serviceInteractions = CSV.read('_data/esdToolkit/services_interactions.csv')

# Load the powers and duties to service
#powersServices = CSV.read('_data/esdToolkit/powersAndDuties_services.csv')
servicePowers = CSV.read('_data/esdToolkit/services_powersAndDuties.csv')

# For each service in CSV file
CSV.foreach('_data/esdToolkit/services.csv') do |row|
  # Skip if it's not in the organisationServices list
  next unless organisationServices.include? row[0]
  
  # Set name for service doc
  name = "_services/" + slugify(row[1]) + ".md"

  # Check if it is an internal service
  internalService = internalServices.include?(row[0])

  # Find functions for the service  
  function = serviceFunctions.select { |func| func[0] == row[0] }.collect { |func| func[8] }.join(", ")

  # Find interactions for the service
  interactions = serviceInteractions.select { |intr| intr[0] == row[0] }.collect { |intr| intr[8] }.join(", ")

  # Find powers and duties for the service  
  #powers = powersServices.select { |pwr| pwr[8] == row[0] }.collect { |pwr| pwr[0] }.join(", ")
  powers = servicePowers.select { |pwr| pwr[0] == row[0] }.collect { |pwr| pwr[8] }.join(", ")

  # Write the doc file using the template (only if the file doesn't exist already)
  File.open(name, 'w') { |file| file.write( serviceTemplate.result(binding) ) } unless File.file?(name)
end

# For each function in CSV file
CSV.foreach('_data/esdToolkit/functions.csv') do |row|
  # Skip if it's not in the organisationFunctions list
  next unless organisationFunctions.include? row[0]
  
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