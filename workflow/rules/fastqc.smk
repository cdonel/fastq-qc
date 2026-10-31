# Rule for running FastQC on each FASTQ file
rule fastqc:
    input:
        fastq = INDIR + "/{genotype}/{biosample}/{run}/{run}_{read}.fastq.gz"
    output:
        html = OUTDIR + "/{genotype}/{biosample}/{run}_{read}_fastqc.html",
        zip = OUTDIR + "/{genotype}/{biosample}/{run}_{read}_fastqc.zip"
    params:
        outdir = lambda wildcards, output: os.path.dirname(output.html)
    conda:
        "../envs/fastq-qc.yaml"
    shell:
        "fastqc {input.fastq} --outdir {params.outdir}"