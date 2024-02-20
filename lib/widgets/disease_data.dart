class Disease {
  final String name;
  final List<String> symptoms;
  final List<String> causes;
  final List<String> precautions;
  

  Disease({
    required this.name,
    required this.symptoms,
    required this.causes,
    required this.precautions,
  });

  toJson() {}
}

// Sample disease data
final List<Disease> diseases = [
  Disease(
    name: 'Fever',
    symptoms: [
      'High body temperature',
      'Headache',
      'Muscle aches',
      'Sweating',
      'Chills',
      'Fatigue',
    ],
    causes: [
      'Viral infections',
      'Bacterial infections',
      'Heat exhaustion',
      'Dehydration',
    ],
    precautions: [
      'Rest in a cool environment',
      'Stay hydrated with water and electrolyte-rich drinks',
      'Take fever-reducing medication (e.g., acetaminophen)',
      'Seek medical attention if fever persists or worsens',
    ],
  ),
  Disease(
    name: 'Headache',
    symptoms: [
      'Pain in head',
      'Sensitivity to light or noise',
      'Nausea',
      'Fatigue',
      'Tension in neck and shoulders',
    ],
    causes: [
      'Tension',
      'Migraine',
      'Sinus pressure',
      'Eye strain',
    ],
    precautions: [
      'Rest in a quiet and dark room',
      'Apply cold compress to forehead or neck',
      'Practice relaxation techniques (e.g., deep breathing)',
      'Avoid triggers such as bright lights or loud noises',
    ],
  ),
  Disease(
    name: 'Malaria',
    symptoms: [
      'Fever',
      'Chills',
      'Sweating',
      'Headache',
      'Muscle aches',
      'Nausea',
      'Vomiting',
    ],
    causes: [
      'Parasitic infection (Plasmodium parasites transmitted by mosquitoes)',
    ],
    precautions: [
      'Use insect repellent and mosquito nets',
      'Wear long-sleeved shirts and pants',
      'Take antimalarial medication as prescribed',
      'Seek medical attention for diagnosis and treatment',
    ],
  ),
  Disease(
    name: 'Cold',
    symptoms: [
      'Runny or stuffy nose',
      'Sore throat',
      'Cough',
      'Sneezing',
      'Fatigue',
      'Mild fever',
    ],
    causes: [
      'Viral infection (common cold viruses such as rhinovirus)',
    ],
    precautions: [
      'Wash hands frequently with soap and water',
      'Avoid close contact with sick individuals',
      'Cover mouth and nose when coughing or sneezing',
      'Stay hydrated and get plenty of rest',
    ],
  ),
  Disease(
    name: 'Cough',
    symptoms: [
      'Persistent coughing',
      'Sore throat',
      'Shortness of breath',
      'Chest congestion',
      'Runny or stuffy nose',
    ],
    causes: [
      'Viral infections (e.g., common cold, flu)',
      'Bacterial infections (e.g., pneumonia)',
      'Allergies',
      'Environmental irritants (e.g., smoke, pollution)',
    ],
    precautions: [
      'Stay hydrated with warm fluids',
      'Use cough drops or lozenges to soothe throat',
      'Avoid irritants such as smoke and pollution',
      'Seek medical attention for persistent or severe cough',
    ],
  ),
  Disease(
    name: 'Chronic Obstructive Pulmonary Disease (COPD)',
    symptoms: [
      'Shortness of breath',
      'Wheezing',
      'Chronic cough with mucus production',
      'Chest tightness',
      'Fatigue',
    ],
    causes: [
      'Smoking',
      'Exposure to air pollutants',
      'Genetic factors',
      'Occupational exposure to dust or chemicals',
    ],
    precautions: [
      'Quit smoking and avoid secondhand smoke',
      'Use air purifiers indoors',
      'Follow prescribed medication regimen (e.g., bronchodilators)',
      'Participate in pulmonary rehabilitation programs',
    ],
  ),
 
];
