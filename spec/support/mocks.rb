def mock_task(stubs={})
  @mock_task ||= mock_model(Task, stubs)
end
