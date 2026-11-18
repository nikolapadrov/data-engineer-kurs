import pandas as pd
R = '/Volumes/bootcamp/northern_star/raw_2025_26/'
m = pd.read_parquet(R + 'matches_2025_26.parquet')

# Oba tima dala gol
# both_scored = (m['home_goals'] >=1) & (m['away_goals'] >= 1)  
# m.loc[both_scored]

# Utakmice 0:0
# both_zero = (m['home_goals'] == 0) & (m['away_goals'] == 0)
# m.loc[both_zero]

# Domacin pobedio sa golom razlike
# home_win_by_one = (m['home_goals'] - m['away_goals']) == 1
# m.loc[home_win_by_one]

# Top 10 ukupno golova
# total_goals = m['home_goals'] + m['away_goals']
# top_ten = total_goals.nlargest(10).index
# m.loc[top_ten]