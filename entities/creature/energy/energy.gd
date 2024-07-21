class_name Energy

static var factors: Dictionary

static func calculate(genome: Genome) -> float:
    var consumed: float = 0
    var gene_value: float
    var factor: Factor

    for gene_name in genome.genes:
        gene_value = genome.genes[gene_name].value
        factor = factors[gene_name]
        consumed += factor.multiplier * pow(gene_value, factor.power)

    return consumed
