from PySide import QtCore, QtGui, QtDeclarative


class MainWnd(QtGui.QMainWindow):
    def __init__(self, parent=None):
        super(MainWnd, self).__init__(parent)

        self.layout = QtGui.QHBoxLayout()

        self.layout.addWidget(QtGui.QPushButton('asd'))
        self.layout.addWidget(QtGui.QPushButton('asd'))

        qmlView = QtDeclarative.QDeclarativeView()
        qmlView.setSource(QtCore.QUrl('view.qml'))
        qmlView.setResizeMode(QtDeclarative.QDeclarativeView.SizeRootObjectToView)

        self.layout.addWidget(qmlView)

        centralWidget = QtGui.QWidget()
        centralWidget.setLayout(self.layout)

        self.setCentralWidget(centralWidget)


if __name__ == '__main__':
    import sys

    app = QtGui.QApplication(sys.argv)
    form = MainWnd()

    form.show()

    sys.exit(app.exec_())
