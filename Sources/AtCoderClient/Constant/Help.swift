let HELP = """

help: このメッセージを表示します。

make [ファイル名] [問題]: 実行ファイルと問題を紐づけます。[ファイル名].swiftが無い場合は新しくファイルを作成します。
                         [ファイル名]には任意のファイル名(拡張子無し)を指定してください。
                         [問題]には英小文字a...zまたは英大文字A...Zのうちのいずれかを設定してください。
                         文字に対応した問題と実行ファイルを紐づけます。対応する問題が無い場合はエラーとなります。

test [問題]: 問題の入力例をもとにテストします。

[問題]: test [問題]の省略系です。

submit [問題]: [問題]を提出します。

quit: このアプリを終了します。

url: 問題のURLを再設定します。

"""
