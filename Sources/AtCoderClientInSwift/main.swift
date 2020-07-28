for input in Shell() {
    let command = input.command
    let args = input.args
    switch command {
    case .help:
        Command.help()
    case .test:
        Command.test(args)
    case .submit:
        Command.submit(args)
    case .nothing:
        continue
    case .quit:
        break
    }
}