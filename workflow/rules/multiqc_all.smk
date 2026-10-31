# Rule for generating a single multiqc report for all samples
rule multiqc_all:
    input:
        [
            f"{OUTDIR}/{g}/{b}/{r}_{read}_fastqc.zip"
            for g, b, r in zip(meta["genotype"], meta["BioSample"], meta["Run"])
            for read in (2, 3)
        ]
    output:
        report = OUTDIR + "/multiqc/multiqc_report.html"
    params:
        outdir = lambda wildcards, output: os.path.dirname(output.report)
    conda:
        "../envs/fastq-qc.yaml"
    shell:
        "multiqc {input} --filename multiqc_report --outdir {params.outdir} --force"