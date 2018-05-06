import UIKit

class ResultViewController: UIViewController {
    @IBOutlet private var resultView: UIView!
    @IBOutlet private var loadingView: UIView!
    @IBOutlet var recyclingCenterName: UILabel!
    private let viewModel: ImageViewModel
    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

    @IBOutlet var categoryName: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var previewImage: UIImageView!

    init(viewModel: ImageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        previewImage.image = viewModel.capturedImage

        title = appName
        loadingView.isHidden = false
        resultView.isHidden = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.update(viewModel: self.viewModel)
        }
    }

    @IBAction func openMapButtonPressed(_: Any) {
        viewModel.openMapAction()
    }
    func update(viewModel: ImageViewModel) {
        loadingView.isHidden = true
        resultView.isHidden = false
        categoryName.text = viewModel.categoryName
        descriptionLabel.text = viewModel.categoryDescription
        recyclingCenterName.text = viewModel.recylingCenterName
    }
}
