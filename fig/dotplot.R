library(dplyr)
library(ggplot2)
library(reshape2)

# Putting tables 4 and 7 into a figure
course <- c("History", "Macroeconomics",
            "Microeconomics", "Political Science",
            "Sociology")
finalexam <- c(0.16, 0.06, -0.01, -0.03, -0.02)
midterm   <- c(0.32, 0.15, 0.13, 0.17, 0.24)
res <- data.frame(course, finalexam, midterm)
colnames(res) <- c("Course", "Final Exam", "Midterm Grades")
res2plot <- melt(res, id.vars="Course")
colnames(res2plot)[2] <- "Grade"
res2plot$Course <- factor(res2plot$Course, levels = res2plot$Course[order(finalexam)])
res2plot$Grade <- factor(res2plot$Grade, levels = c("Midterm Grades", "Final Exam"))

p <- ggplot(res2plot, aes(x = value, y = Course)) + 
  geom_point(size = 5, aes_string(color="Grade", shape="Grade")) + 
  geom_vline(xintercept = 0, linetype = "dotted") +   
#  geom_vline(xintercept = 0.1, linetype = "dotted") + 
  xlab("Correlation") + ylab("") +
  ggtitle("Correlation between SET and Grades") +
  theme_bw() + 
#  scale_x_continuous(breaks = c(0, 0.05, 0.1, 0.25, 0.5, 0.75, 1)) +
  theme(axis.text = element_text(size = 16)) +
  theme(axis.title = element_text(size = 16)) +
  theme(legend.text = element_text(size = 16)) + 
  theme(title = element_text(size=20)) +
  coord_flip() +
  theme(axis.text.x=element_text(angle=-45, hjust=0)) +
  theme(legend.position = "bottom") +
  theme(legend.title=element_blank())
png("dotplot.png", width = 500, height = 600)
p
dev.off()
