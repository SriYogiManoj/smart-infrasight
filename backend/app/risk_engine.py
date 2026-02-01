def calculate_risk(asset):
    score = 0

    if asset.in_flood_zone:
        score += 30
    if asset.in_cyclone_zone:
        score += 25
    if asset.near_tree:
        score += 15
    if asset.age > 20:
        score += 20
    if asset.last_inspection_days > 365:
        score += 10

    return min(score, 100)
