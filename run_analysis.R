run_analysis <- function(outfile = NULL, ...) {
    activities <- dt("activity_labels.txt", c("activity_id", "activity"), "activity_id")
    setkey(activities, activity_id)
#     print(activities)
    
    features <- dt("features.txt", c("feature_id", "feature"))
    totfeatures <- dim(features)[1]

    # retain only std and mean features
    features <- features[c(grep("-std()-", features$feature, fixed=TRUE), grep("-mean()-", features$feature, fixed=TRUE)), ]

    # order by the feature_id
    setkey(features, feature_id)
#     print(features)    

    data <- rbind(obs("train", activities, features, totfeatures), obs("test", activities, features, totfeatures))
    data <- aggregate(data[, 1:dim(features)[1], with=FALSE], list(activity =data$activity, subject = data$subject), mean)
    if(!is.null(outfile)) write.table(data, outfile, row.names=FALSE, ...)
    data
}

obs <- function(type, activities, features, totfeatures) {
    colClasses <- rep("NULL", totfeatures)
    colClasses[features$feature_id] <- NA
    
    data <- read.table(paste0(type, "/X_", type, ".txt"), colClasses=colClasses)    
    colnames(data) <- features$feature
    
    data <- data.table(data)
    activityData <- dt(paste0(type, "/y_", type, ".txt"))
    activityData <- activities[activityData]$activity

    data <- data[, activity := activityData]
    data <- data[, subject := dt(paste0(type, "/subject_", type, ".txt"))]
    data
}

dt <- function (file, col_names=NULL, keyCol=NULL) {
    res <- fread(file)
    if (!is.null(col_names)) setnames(res, col_names)
    if(!is.null(keyCol)) setkeyv(res, keyCol)
    res
}