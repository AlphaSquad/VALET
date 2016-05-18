Docker container to run VALET read based assembly evaluation

build with

`sudo docker build --tag=valet .`

create input output and (optionally) cache directories, mount accordingly
choose task to be run (default)

`sudo docker run -v input:/bbx/mnt/input:ro -v output:/bbx/mnt/output:rw -v cache:/bbx/mnt/cache:rw valet default`
