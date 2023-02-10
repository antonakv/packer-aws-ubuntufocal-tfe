# packer-aws-ubuntufocal
Packer build of Ubuntu Focal AMI image

## Intro
This manual is dedicated to create AWS image with Ubuntu Focal and TFE replicated installer

- Change folder to packer-aws-ubuntufocal-tfe

```bash
cd packer-aws-ubuntufocal-tfe
```

## Build
- In the same folder you were before run 

```bash
packer init template.pkr.hcl
packer build template.pkr.hcl
```

