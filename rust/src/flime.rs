struct Session {
    commit_text: String,
    engine: Engine,
}

impl Session {
    fn new() -> Self {
        Self {
            commit_text: String::new(),
            engine: Engine::new(),
        }
    }

    pub fn process_key(&self) {}

    pub fn apply_schema(&self) {}

    pub fn reset_commit_text(&mut self) {
        self.commit_text.clear();
    }

    pub fn commit_text(&self) -> &str {
        self.commit_text.as_ref()
    }

    fn on_commit(&self) {}
}

struct Engine {
    context: Context,
}

impl Engine {
    fn new() -> Self {
        Self {
            context: Context::new(),
        }
    }

    fn init(&self) {}
}

struct Context {}

impl Context {
    fn new() -> Self {
        Self {}
    }
}
