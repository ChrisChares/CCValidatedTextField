Pod::Spec.new do |s|
  s.name         = 'CCValidatedTextView'
  s.version      = '1.0.0'
  s.summary      = 'Real-time UITextField validation via blocks'
  s.author = {
    'Chris Chares' => 'chris@eunoia.cc'
  }
  s.source = {
    :git => 'https://github.com/ChrisChares/CCValidatedTextField.git',
    :tag => '1.0.0'
  }
  s.source_files = 'ValidatedTextField/*.{h,m}'
end