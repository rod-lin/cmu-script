# cmu-script
Some util scripts for CMU Linux Timeshare

## Usage

**andrew**

    andrew [andrew_id password]
    # this will log you in to the Timeshare. Andrew ID and password are only required on the first run

**andscp**
   
    andscp <arguments that will be passed to scp>
    # e.g.
    #     andscp ~/local :~/server
    #     is equivalent to
    #     scp ~/local <Andrew ID>@linux.andrew.cmu.edu:~/server
    #     but without the need to type password

