class_name Energy

static var factors: Dictionary = {
    "speed": Factor.new(1, 1),
    "view_radius": Factor.new(1, 1),
    "hatching_time": Factor.new(0, 1),
}

static func calculate(genome: Genome) -> float:
    var consumed: float = 0
    var gene_value: float
    var factor: Factor

    for gene_name in genome.genes:
        gene_value = genome.genes[gene_name].value
        factor = factors[gene_name]
        consumed += factor.multiplier * pow(gene_value, factor.power)

    return consumed
