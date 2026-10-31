# Rule for generating a multiqc report for each genotype/biosample pair
def fastqc_for_group(wildcards):
    """All FastQC zips for one genotype/biosample pair."""
    runs = groups[(wildcards.genotype, wildcards.biosample)]
    return [
        f"{OUTDIR}/{wildcards.genotype}/{wildcards.biosample}/{r}_{read}_fastqc.zip"
        for r in runs
        for read in (2, 3)
    ]


# Rule for generating a multiqc report for each genotype/biosample pair
rule multiqc_samples:
    input:
        fastqc_for_group
    output:
        report = OUTDIR + "/{genotype}/{biosample}/{biosample}_multiqc.html"
    params:
        outdir = lambda wildcards, output: os.path.dirname(output.report),
        name = lambda wildcards: f"{wildcards.biosample}_multiqc"
    conda:
        "../envs/fastq-qc.yaml"
    shell:
        "multiqc {input} --filename {params.name} --outdir {params.outdir} --force -q"