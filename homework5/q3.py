# Question 3: load the model with pickle and score one lead
import pickle

# 'rb' = read binary (same as your predict.py)
with open('pipeline.bin', 'rb') as f_in:
    pipeline = pickle.load(f_in)

# This time there's no separate dv: pipeline.bin is a sklearn Pipeline
# = DictVectorizer + LogisticRegression glued together, so it takes raw dicts.
print(pipeline)

lead = {
    "lead_source": "paid_ads",
    "industry": "technology",
    "employment_status": "employed",
    "location": "north_america",
    "number_of_courses_viewed": 2,
    "annual_income": 79276.0,
    "interaction_count": 4,
    "lead_score": 0.41,
}

# predict_proba returns [[P(not converted), P(converted)]] -> take [0, 1]
prob = pipeline.predict_proba([lead])[0, 1]
print(f"Q3 conversion probability: {prob:.3f}")
