ADD file:c92c248239f8c7b9b3c067650954815f391b7bcb09023f984972c082ace2a8d0 in /
CMD ["/bin/sh"]
COPY file:fd6d96eb51adda40a1b3855689e9e605dab6541dcd506bc04adbd4b49f244a32 in /
/bin/sh -c apk add --update nodejs npm
/bin/sh -c mkdir /deployments
COPY file:e07a31a859a2de377f530b7303062942cec42d4b7dc37da218a3f042ba56da6f in /deployments
COPY file:5581066958e20f07267b1c05d706b3bebe16be2b951fbac7265ca800a3af7922 in /deployments
COPY multi:1cdcedb2e7674dd9ceab77887e6344b2470b59b342c0157f4556a3021fdc4bfa in /deployments/responses/
COPY multi:97e8feb5a0ab3d86747b98fb0b5bd335b833fc12076313e46c06b5b911b302db in /deployments/origins/
COPY file:ed9aff8360c1a3a14705f9618f194d0210028ecc264f9f8318a6a402ace50158 in /deployments/data/
/bin/sh -c ls /deployments
ENTRYPOINT ["/hoverfly" "-listen-on-host=0.0.0.0" "-webserver" "-import=/deployments/simulation.json" "--middleware" "node /deployments/mid.js"]
CMD [""]
EXPOSE 8500



