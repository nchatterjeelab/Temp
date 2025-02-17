
## Suppl Fig 4

library(latex2exp)
library(ggplot2)

barCOLS = c("#008fd5","#de6b35")
dotCOLS = c("#a6d8f0","#f9b282")

ax1 = read_excel("ExtendedDataFig4.xlsx", sheet = "4a")
enr1 <- ggplot(ax1, aes(x=X, y=odr.ea, ymin=log(lower.ci,base = 2), ymax=log(upper.ci,base = 2))) +
  #specify position here
  geom_linerange(size=1,position=position_dodge(width = 0.2)) +
  geom_hline(yintercept=0, lty=2,colour = "grey") +
  #specify position here too
  geom_point(size=1, shape=19, colour="red", stroke = 0.5,position=position_dodge(width = 0.2)) +
  scale_fill_manual(values=barCOLS)+
  scale_color_manual(values=dotCOLS)+
  scale_x_discrete(name="Functional Annotations") +
  scale_y_continuous(name=expression("log"[2]*"(enrichment)"), limits = c(-4, 8)) +
  coord_flip() +
  theme_minimal() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                          panel.grid.minor = element_blank(),axis.title = element_text(size = 6),title = element_text(size = 7),axis.text = element_text(size = 6))  + 
  ggtitle(paste0("European Americans (EA)"))


ax2 = read_excel("ExtendedDataFig4.xlsx", sheet = "4b")
enr2 <- ggplot(ax2, aes(x=X, y=odr.aa, ymin=log(lower.ci,base = 2), ymax=log(upper.ci,base = 2))) +
  #specify position here
  geom_linerange(size=1,position=position_dodge(width = 0.2)) +
  geom_hline(yintercept=0, lty=2,colour = "grey") +
  #specify position here too
  geom_point(size=1, shape=19, colour="red", stroke = 0.5,position=position_dodge(width = 0.2)) +
  scale_fill_manual(values=barCOLS)+
  scale_color_manual(values=dotCOLS)+
  scale_x_discrete(name="Functional Annotations") +
  scale_y_continuous(name=expression("log"[2]*"(enrichment)"), limits = c(-4, 8)) +
  coord_flip() +
  theme_minimal() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                          panel.grid.minor = element_blank(),axis.title = element_text(size = 6),title = element_text(size = 7),axis.text = element_text(size = 6)) + 
  ggtitle("African Americans (AA)")


enr.aa.x = read_excel("ExtendedDataFig4.xlsx", sheet = "4c")
enr3 <- ggplot(enr.aa.x, aes(x=X1, y=V2, ymin=sapply(V4,FUN = function(x){return(max(x,-1))}), ymax=V5)) +
  #specify position here
  geom_linerange(size=1,position=position_dodge(width = 0.2)) +
  geom_hline(yintercept=0, lty=2,colour = "grey") +
  #specify position here too
  geom_point(size=1, shape=19, colour="red", stroke = 0.5,position=position_dodge(width = 0.2)) +
  scale_fill_manual(values=barCOLS)+
  scale_color_manual(values=dotCOLS)+
  scale_x_discrete(name="Functional Annotations") +
  scale_y_continuous(name=expression("log"[2]*"(enrichment)"), limits = c(-2, 4)) +
  coord_flip() + ggtitle(paste0("European Americans (EA)")) +
  theme_minimal() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                          panel.grid.minor = element_blank(),axis.title = element_text(size = 6),title = element_text(size = 7),axis.text = element_text(size = 6))




enr.ea.x = read_excel("ExtendedDataFig4.xlsx", sheet = "4d")
enr4 <- ggplot(enr.ea.x, aes(x=X1, y=V2, ymin=sapply(V4,FUN = function(x){return(max(x,-1))}), ymax=V5)) +
  #specify position here
  geom_linerange(size=1,position=position_dodge(width = 0.2)) +
  geom_hline(yintercept=0, lty=2,colour = "grey") +
  #specify position here too
  geom_point(size=1, shape=19, colour="red", stroke = 0.5,position=position_dodge(width = 0.2)) +
  scale_fill_manual(values=barCOLS)+
  scale_color_manual(values=dotCOLS)+
  scale_x_discrete(name="Functional Annotations") +
  scale_y_continuous(name=expression("log"[2]*"(enrichment)"), limits = c(-2, 4)) +
  coord_flip() + ggtitle(paste0("African Americans (AA)")) +
  theme_minimal() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                          panel.grid.minor = element_blank(),axis.title = element_text(size = 6),title = element_text(size = 7),axis.text = element_text(size = 6))


###############################################################
###############################################################
###############################################################


p <- ggarrange(ggarrange(enr1, enr2,
                         ncol = 2, labels = c("a", "b"),
                         heights = c(0.5,0.5)),
               ggarrange(enr3, enr4,
                         ncol = 2, labels = c("c", "d"),
                         heights = c(0.5,0.5)),
               nrow = 2, 
               labels = c(NA, NA),
               widths = c(0.5,0.5)
)

ggsave(filename=paste0("ExtendedDataFigure4.pdf"), 
       plot=p, device="pdf",
       path="/Users/jnz/Dropbox/PWAS_manuscript/NatureGenetics/2021_12_revision4/Final_files_prepared_for_submission/Figures/", 
       width=180, height=105, units="mm", dpi=320)





