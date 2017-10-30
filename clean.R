# Get dependencies
library(jsonlite)
library(data.table)

# Get source json data
json_file = file("stdin")
json_source <- fromJSON(json_file)

# Get vals
readings <- json_source$data$vals
names(readings) <- "value"


# Get sensor names
sensor_names <- json_source$head$fields$name


# Transpose
sensors <- as.data.frame(readings, row.names = sensor_names)
tsensors <- transpose(sensors)
colnames(tsensors) <- rownames(sensors)


# Get timestamp
timestamp <- json_source$data$time

data_simple <- cbind(tsensors,timestamp)


# Create clean simple json
json_output_simple <- toJSON(data_simple)
json_output_simple

