#library("workflowr")
#wflow_start("tlcf")

wflow_open("analysis/tp_20200324.Rmd") # talking points

#wflow_build()
wflow_status()
wflow_publish(c("analysis/index.Rmd",
                "analysis/banerjee.Rmd","analysis/altmin_ideas.Rmd", "analysis/noisyparam_sim.Rmd"),
              "AltMin simulation analysis")

wflow_publish(c("code/*", "output/*"),
              "matlab code and outputs")



wflow_use_github("joonsukkang")
wflow_git_push()


